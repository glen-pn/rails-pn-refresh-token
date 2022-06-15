class Api::V1::HomeController < ApplicationController

  before_action :authenticate_user!, only: [:generate_token]
  before_action :initialize_pubnub, only: [:generate_token]

  def generate_token
    return render json: {
      message: "Refresh token",
      token: @@refresh_token
    }
  end

  private

    def initialize_pubnub
      type = params[:type]
      pub_key = params[:pub]
      sub_key = params[:sub]
      secret = params[:secret]
      uuid = current_user.uuid
      channels_array = params[:channels]

      @@pubnub = Pubnub.new(
        subscribe_key: sub_key,
        publish_key: pub_key,
        secret_key: secret,
        uuid: uuid
      )

      channels_obj = {}

      channels_array.each do |channel|
        channels_obj[channel] = Pubnub::Permissions.res( read: true, write: true )
      end

      new_token = @@pubnub.grant_token(
        ttl: 17280,
        authorized_uuid: uuid,
        channels: channels_obj
      ).value

      @@refresh_token = new_token.as_json['result']['data']['token']
    end
end
