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

        result = Villeme::UseCases::Dates.new(event, true).get_next_day_occur_human_readable

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

        result = Villeme::UseCases::Dates.new(event, true).get_next_day_occur_human_readable

        expect(result).to eq 'Tomorrow'
      end
    end

    context 'when object occur in saturday' do
      it 'should return saturday' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.new(event, true).get_next_day_occur_human_readable

        expect(result).to eq 'Saturday'
      end
    end

    context 'when object occur in 30 days period' do
      it 'should return 29/Mar' do
        event = build(:event, date_start: @date_current + 10, date_finish: @date_current + 30)
        weeks_array = [double('Week', id: 4, name: "Thursday", binary: 4, organizer_id: 4),
                       double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.new(event, true).get_next_day_occur_human_readable

        expect(result).to eq '29/Mar'
      end
    end

    context 'when object occur in 60 days period' do
      it 'should return 18/May' do
        event = build(:event, date_start: @date_current + 60, date_finish: @date_current + 65)
        weeks_array = [double('Week', id: 1, name: "Monday", binary: 1, organizer_id: 1),
                       double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.new(event, true).get_next_day_occur_human_readable

        expect(result).to eq '18/May'
      end
    end

  end

  describe 'today?' do
    context 'when object occur today' do
      it 'should return TRUE' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 4, name: "Thursday", binary: 4, organizer_id: 4),
                       double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.new(event, true).today?

        expect(result).to be_truthy
      end
    end
    context 'when object occur tomorrow' do
      it 'should return FALSE' do
        event = build(:event, date_start: @date_current, date_finish: @date_current + 6)
        weeks_array = [double('Week', id: 5, name: "Friday", binary: 5, organizer_id: 5),
                       double('Week', id: 6, name: "Saturday", binary: 6, organizer_id: 6),
                       double('Week', id: 7, name: "Sunday", binary: 0, organizer_id: 7)]
        allow(event).to receive(:weeks).and_return(weeks_array)

        result = Villeme::UseCases::Dates.new(event, true).today?

        expect(result).to be_falsey
      end
    end
  end

end