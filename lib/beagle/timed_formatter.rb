require 'rspec/core/formatters/base_formatter'
require 'erb'

module Beagle

  class TimedFormatter < RSpec::Core::Formatters::BaseFormatter

    def initialize(options)
      super
      @metrics = Hash.new{|h,k| h[k] = Beagle::Examples.new}
    end

    def example_started(example)
      super
      parts = example.file_path.split('/spec/')
      @out_dir ||= "#{parts(example).first}/reports/beagle"
      @type = type(example)
      @metrics[@type].add(example)
      @start_time = Time.now
    end

    def example_passed(example)
      super
      set_time(example)
    end

    def example_failed(example)
      super
      set_time(example)
    end

    def start_dump
      template = File.read(File.expand_path('../templates/index.rhtml', File.dirname(__FILE__)))
      rhtml = ERB.new(template, nil, ">")
      metrics = Beagle::Metrics.new(@metrics)
      FileUtils.mkdir_p @out_dir
      outfile = "#{@out_dir}/index.html"
      FileUtils.rm_rf outfile
      File.open(outfile, 'w') {|f| f.write(rhtml.result(metrics.get_binding)) }
      copy_javascript_files
    end

    private 
    def copy_javascript_files
      FileUtils.cp_r File.expand_path('../js', File.dirname(__FILE__)), "#{@out_dir}/"
    end

    def set_time(example)
      @metrics[@type].set_time(example, Time.now - @start_time)
    end

    def parts(example)
      example.file_path.split('/spec/')
    end

    def type(example)
      parts(example).last.split('/').first
    end

  end

end