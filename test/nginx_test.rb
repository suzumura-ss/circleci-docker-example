require_relative 'test_helper'


module TestNginxMedia
  API_HOST  = ENV['API_HOST']  || 'http://localhost:3000'

  class Root < Minitest::Test
    def test_get_root
      body, header, code = Helper::Rest.get(API_HOST, to_json:false, follow_redirect:false)
      assert{ code == 200 }
    end

    def test_get_root_slash
      body, header, code = Helper::Rest.get(API_HOST+'/', to_json:false, follow_redirect:false)
      assert{ code == 200 }
    end
  end


  class GET < Minitest::Test
    URI = File.join(API_HOST, 'media', 'xx-xx-xx')
    def test_succeed
      body, header, code = Helper::Rest.get(URI+'?foo=bar')
      assert{ code==200 }
      assert{ body.resuest_id }
    end
  end
end
