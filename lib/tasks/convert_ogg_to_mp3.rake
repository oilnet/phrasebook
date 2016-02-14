require 'fileutils'

namespace :data do
  desc "convert OGG recordings to MP3"
  task :convert => :environment do
    FileUtils.mkdir_p 'tmp/recordings'
    Translation.all.each do |t|
      if t.recording_data
        puts "#{t.id} #{t.text}"
        File.open("tmp/recordings/#{t.id}.ogg", 'wb') do |file|
          file.write t.recording_data
          ffmpeg = FFMPEG::Movie.new(file.path)
          mp3_file = "tmp/recordings/#{t.id}.mp3"
          mp3_data = ffmpeg.transcode(mp3_file)
          t.recording_data = File.read(mp3_file)
          t.save
        end
      end
    end
  end
end
