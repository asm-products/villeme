require 'rails_helper'
require_relative '../../app/domain/usecases/dates/get_next_day_occur_human_readable'

describe 'UseCases::Dates' do

  before(:all) do
    I18n.locale = :en
    @date_current = Date.parse('19-03-2015')
  end

  describe 'get_next_day_occur_human_readable' do
    context 'when object occur today' do
      it 'should return today' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 4, name: "Thursday", binary: 4, organizer_id: 4),
                       double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.get_next_day_occur_human_readable(event, true)

        expect(result).to eq 'Today'
      end
    end

    context 'when object occur tomorrow' do
      it 'should return tomorrow' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.get_next_day_occur_human_readable(event, true)

        expect(result).to eq 'Tomorrow'
      end
    end

    context 'when object occur in saturday' do
      it 'should return saturday' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.get_next_day_occur_human_readable(event, true)

        expect(result).to eq 'Saturday'
      end
    end

    context 'when object occur in 30 days period' do
      it 'should return 19/Mar' do
        event = build(:event, date_start: @date_current + 10, date_finish: @date_current + 30)
        weeks_array = [double('Week', id: 4, name: "Thursday", binary: 4, organizer_id: 4)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.get_next_day_occur_human_readable(event, true)

        expect(result).to eq '19/Mar'
      end

      it 'should return 10' do
        event = build(:event, date_start: @date_current + 10, date_finish: @date_current + 30)
        weeks_array = [double('Week', id: 4, name: "Thursday", binary: 4, organizer_id: 4)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.get_next_day_occur_human_readable(event, true)

        expect(result).to eq '19/Mar'
      end

    end

  end

end