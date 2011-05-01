module Beagle

  class Examples

    def initialize
      @entries = Hash.new{|h,k|h[k] = []}
    end

    def add(example)
      @entries[example.file_path] << [example.full_description, 0]
    end

    def set_time(example, time)
      @entries[example.file_path].last[1] = time
    end

    def files
      files = []
      @entries.each do |file, examples|
        time = examples.inject(0) {|sum, example| sum + example.last}
        files << [file, examples.size, time]
      end
      files.sort {|a,b|b.last <=> a.last}
    end

    def examples(file_path)
      @entries[file_path].sort {|a,b|b.last <=> a.last}
    end

    def size
      @size ||= @entries.values.size
    end

    def duration
      @duration ||= files.inject(0) {|sum, example| sum + example.last}
    end

  end

end