require "./spec_helper"

describe Sentry do
  it "create sentry.lock" do
    File.write(Sentry::Config::INSTANCE.lock, "")
    exists? = File.exists? Sentry::Config::INSTANCE.lock
    exists?.should eq(true)
  end

  it "delete sentry.lock" do
    File.delete Sentry::Config::INSTANCE.lock
    exists? = File.exists? Sentry::Config::INSTANCE.lock
    exists?.should eq(false)
  end
end
