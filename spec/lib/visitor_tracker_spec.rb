require 'visitors_counter/tracker'

RSpec.describe VisitorsCounter::Tracker do
  describe '#visited_pages' do
    it 'should be an Array' do

    end

    it 'should be empty for default' do

    end

    it 'should contains visited page ID/IDs' do

    end

    it 'will be reduced when user leaving a page' do

    end
  end

  describe '#user_id' do
    context 'user logged in' do
      it 'should be encryped user.id'
    end
    context 'user is logged in' do
      it 'should be a random key'
      it 'should be changed to user.id when user logged in' do

      end
    end
  end

  describe '#total_page_visitors' do
    it 'requires page name argument' do
      # page name is retrieved from #page_name_converter
    end

    it 'requires ID argument' do

    end

    it 'returns total visitors of a page' do
      # we will use hash data structure
    end
  end

  describe '#page_name_converter' do
    it 'converts given page url to shorten page id' do

    end
  end
end
