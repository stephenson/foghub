require_relative './test_helper'
require_relative '../lib/foghub/foghub'

class CommitMessage < FogTest
  def app
    Foghub.new
  end

  def github_data(message)
    {
      :before => "5aef35982fb2d34e9d9d4502f6ede1072793222d",
      :repository => {
        :url => "http://github.com/firmafon/foghub",
        :name => "github",
        :description => "Foghub associates Git commits with Fogbugz cases and code reviews.",
        :watchers => 2,
        :forks => 1,
        :private => 0,
        :owner => {
          :email => "teknik@firmafon.dk",
          :name => "firmafon"
        }
      },
      :commits => [
        {
          :id => "41a212ee83ca127e3c8cf465891ab7216a705f59",
          :url => "http://github.com/firmafon/foghub/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
          :author => {
            :email => "sirup@sirupsen.com",
            :name => "Sirupsen"
          },
          :message => message,
          :timestamp => "2008-02-15T14:57:17-08:00",
          :added => ["ohai.rb"]
        },
      ],
      :after => "de8251ff97ee194a289832576287d6f8ad74e3d0",
      :ref => "refs/heads/master"
    }
  end

  def test_webhook_success
    post '/commit', github_data('useless commit')

    assert last_response.ok?
  end
end
