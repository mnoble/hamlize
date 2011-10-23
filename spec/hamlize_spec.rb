require "spec_helper"

describe "Hamlize" do
  let(:source) { File.dirname(__FILE__) + "/sandbox/source" }
  let(:dest)   { File.dirname(__FILE__) + "/sandbox/source/compiled" }
  let(:files)  { File.dirname(__FILE__) + "/sandbox/files" }
  let(:site)   { File.dirname(__FILE__) + "/sandbox/source/site" }
  let(:sand)   { File.dirname(__FILE__) + "/sandbox/sand" }

  after(:all) do
    Pathname.new(dest).rmtree rescue nil
    Pathname.new(site).rmtree rescue nil
    Pathname.new(sand).rmtree rescue nil
  end

  before do
    Dir.stub(:pwd).and_return(source)
  end

  it "compiles a directory of HAML" do
    Hamlize::CLI.new.start!
    output_matches(dest).should be_true
  end

  it "supports specifying a destination" do
    Hamlize::CLI.new(["-o", site]).start!
    output_matches(site).should be_true
  end

  it "supports a destination that is above the source" do
    # File.expand_path is in C, so we can't stub where it gets `pwd` from.
    converter = Hamlize::Converter.new(source: source, output: sand)
    Hamlize::Converter.stub(:new).and_return(converter)
    Hamlize::CLI.new(["-o", "../sand"]).start!
    output_matches(sand).should be_true
  end

  it "supports specifying a source directory" do
    Hamlize::CLI.new(["-s", files]).start!
    output_matches(dest).should be_true
  end

  def output_matches(dest)
    files = Pathname.glob("#{dest}/**/*.html").map(&:to_s)
    files == ["#{dest}/index.html", "#{dest}/pages/toc.html"]
  end
end
