# == Schema Information
#
# Table name: pull_requests
#
#  id                  :uuid             not null, primary key
#  base_repo_full_name :string(255)
#  number              :integer
#  user_id             :uuid
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe PullRequest do
  pending "add some examples to (or delete) #{__FILE__}"
end
