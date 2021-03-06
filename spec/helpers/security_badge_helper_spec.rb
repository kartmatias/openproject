#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe SecurityBadgeHelper, type: :helper do
  describe '#security_badge_url', with_settings: { installation_uuid: 'abcd1234' } do
    it "generates a URL with the release API path and the details of the installation" do
      uri = URI.parse(helper.security_badge_url)
      query = Rack::Utils.parse_nested_query(uri.query)
      expect(uri.host).to eq("releases.openproject.com")
      expect(query.keys).to match_array(["uuid", "type", "version", "db", "lang", "ee"])
      expect(query["uuid"]).to eq("abcd1234")
      expect(query["version"]).to eq(OpenProject::VERSION.to_s)
      expect(query["type"]).to eq("manual")
      expect(query["ee"]).to eq("false")
    end
  end
end
