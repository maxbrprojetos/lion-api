module Graph
  AuthMutationType = GraphQL::ObjectType.define do
    name "AuthMutation"
    description "The mutation root of this schema"

    field :token_create, Graph::TokenType do
      argument :code, !types.String, "The authorization code for the user"
      resolve -> (object, arguments, context) do
        user = if ENV['DISABLE_GOOGLE_AUTH'] == "true"
          User.first
        else
          app_client = Octokit::Client.new(
            client_id: ENV['GITHUB_APP_ID'],
            client_secret: ENV['GITHUB_APP_SECRET']
          )
          token = app_client.exchange_code_for_token(arguments[:code])
          user_client = Octokit::Client.new(access_token: token.access_token)

          user_data = user_client.user

          if user_data.email.blank?
            user_data.email = user_client.emails.find(&:primary).email
          end

          User.find_or_create_from_oauth(user_data, token.access_token)
        end

        if user.present? && user.persisted?
          user.access_tokens.active.first_or_create
        end
      end
    end
  end
end
