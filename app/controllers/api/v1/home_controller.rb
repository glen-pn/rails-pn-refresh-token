class Api::V1::HomeController < ApplicationController

  before_action :initialize_pubnub, only: [:generate_token]

  def generate_token
    return render json: {
      message: "Here's the message"
    }
  end

  private

    def initialize_pubnub
      # @@pubnub = Pubnub.new(
      #   subscribe_key: :mySubscribeKey,
      #   publish_key: :myPublishKey,
      #   uuid: :myUniqueUUID
      # )
    end
end
