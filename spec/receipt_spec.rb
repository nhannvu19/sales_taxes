require 'spec_helper'

describe Receipt do
  let(:filepath) { 'no-exist.csv' }
  let(:test_cases) do
    {
      "#{RSPEC_ROOT}/fixtures/input_1.csv" => ['1.50', '29.83'],
      "#{RSPEC_ROOT}/fixtures/input_2.csv" => ['7.65', '65.15'],
      "#{RSPEC_ROOT}/fixtures/input_3.csv" => ['6.70', '74.68']
    }
  end

  describe '#execute' do
    subject { described_class.new(filepath).execute }

    context 'file is missing' do
      it 'print and exit' do
        expect(subject).to eq [-1, 'file_missing']
      end
    end

    describe 'run by test cases' do
      it 'should be correct' do
        test_cases.each do |filepath, (expect_total_tax, expect_total_amount)|
          subject = described_class.new(filepath)
          actual_total_tax, actual_total_amount = subject.execute

          expect(actual_total_tax).to eq expect_total_tax
          expect(actual_total_amount).to eq expect_total_amount
        end
      end
    end
  end
end
