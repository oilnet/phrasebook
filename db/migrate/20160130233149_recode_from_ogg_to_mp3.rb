class RecodeFromOggToMp3 < ActiveRecord::Migration
  def up
    Translation.all.each do |t|
      puts t.text if t.text
      ogg = Tempfile.new('old', encoding: 'ascii-8bit')
      if t.recording_data
        ogg << t.recording_data
        ffmpeg = FFMPEG::Movie.new(ogg.path)
        mp3 = '/tmp/new.mp3'
        mp3_data = ffmpeg.transcode(mp3)
        t.recording_data = File.read(mp3)
        t.save
        FileUtils.rm(mp3)
      end
      ogg.close
      ogg.unlink
    end
  end
end
