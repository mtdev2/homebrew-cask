cask "tap-forms" do
  version "5.3.41,dLlrE4jNTVumseG6si5D"
  sha256 "b2280d66fa80f520c63c0b371c3b585940aa4d5ac8cc6e3645bb2715684fecaf"

  url "https://paddle.s3.amazonaws.com/fulfillment_downloads/9234/503174/#{version.csv.second}_Tap%20Forms%20Install%20#{version.csv.first}.dmg",
      verified: "paddle.s3.amazonaws.com/"
  name "Tap Forms 5"
  desc "Helps to organise important files in one place"
  homepage "https://www.tapforms.com/"

  livecheck do
    url "https://vendors.paddle.com/download/product/503174"
    regex(/([A-z0-9]+)[._-]Tap%20Forms%20Install%20v?(\d+(?:\.\d+)+)\.dmg/i)
    strategy :header_match do |headers, regex|
      match = headers["location"]&.match(regex)
      next if match.blank?

      "#{match[2]},#{match[1]}"
    end
  end

  depends_on macos: ">= :mojave"

  app "Tap Forms Mac #{version.major}.app"

  zap trash: [
    "~/Library/Application Scripts/com.tapzapp.tapforms-mac",
    "~/Library/Containers/com.tapzapp.tapforms-mac",
  ]

  caveats do
    requires_rosetta
  end
end
