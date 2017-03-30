require "./spec_helper"

describe Sentry do
  it "create sentry.lock" do
    File.write(Sentry::LOCK, "")
    exists? = File.exists? Sentry::LOCK
    exists?.should eq(true)
  end

  it "delete sentry.lock" do
    File.delete Sentry::LOCK
    exists? = File.exists? Sentry::LOCK
    exists?.should eq(false)
  end
end
