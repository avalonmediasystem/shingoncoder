require 'open3'
module Shingoncoder::Backend
  class TranscodeService
    include Open3
    class_attribute :config, :timeout
    self.config = Config.new

    BLOCK_SIZE = 1024

    # @param [Fixnum] id the Output ID (not to be confused with the job_id)
    def initialize(id)
      @id = id
    end

    def transcode
      execute "#{config.ffmpeg_path} #{input_options} -i \"#{input_path}\" #{output_options} #{output_path}"
    end

    private

    def output_path
      URI(output.url).path
    end

    def input_path
      URI(output.job.input.fetch('input')).path
    end

    def output
      @output ||= JobRegistry::Output.find(@id)
    end

    def output_format
      @format ||= File.extname(output.url).sub(/\./, '')
    end

    def size_attribute
      output.config.fetch('size', config.size_attributes)
    end

    def codecs(format)
      case format
      when 'mp4'
        config.mpeg4.codec
      when 'webm'
        config.webm.codec
      when "mkv"
        config.mkv.codec
      when "jpg"
        config.jpeg.codec
      else
        raise ArgumentError, "Unknown format `#{format}'"
      end
    end

    def input_options
      output_format == 'jpg' ? " -itsoffset -2" : ''
    end

    def output_options
      output_options = "-s #{size_attribute} #{codecs(output_format)}"

      output_options+= case output_format
      when "jpg"
        " -vframes 1 -an -f rawvideo"
      else
        " #{config.video_attributes} #{config.audio_attributes}"
      end
    end

    def execute(command)
      context = {}
      if timeout
        execute_with_timeout(timeout, command, context)
      else
        execute_without_timeout(command, context)
      end
    end

    def execute_with_timeout(timeout, command, context)
      begin
        status = Timeout::timeout(timeout) do
          execute_without_timeout(command, context)
        end
      rescue Timeout::Error => ex
        pid = context[:pid]
        Process.kill("KILL", pid)
        raise TimeoutError, "Unable to execute command \"#{command}\"\nThe command took longer than #{timeout} seconds to execute"
      end

    end

    def execute_without_timeout(command, context)
      exit_status = nil
      err_str = ''
      stdin, stdout, stderr, wait_thr = popen3(command)
      context[:pid] = wait_thr[:pid]
      stdin.close
      stdout.close
      files = [stderr]

      until all_eof?(files) do
        ready = IO.select(files, nil, nil, 60)

        if ready
          readable = ready[0]
          readable.each do |f|
            fileno = f.fileno

            begin
              data = f.read_nonblock(BLOCK_SIZE)

              case fileno
                when stderr.fileno
                  err_str << data
              end
            rescue EOFError
              Rails.logger "Caught an eof error in ShellBasedProcessor"
              # No big deal.
            end
          end
        end
        end
        exit_status = wait_thr.value

        raise "Unable to execute command \"#{command}\". Exit code: #{exit_status}\nError message: #{err_str}" unless exit_status.success?
      end

      def all_eof?(files)
        files.find { |f| !f.eof }.nil?
      end
  end
end
