require 'spec_helper'

describe Item do
  let(:quantity) { 1 }
  let(:product) { 'mobile phone' }
  let(:price) { 10_000 }
  subject { Item.new(quantity, product, price) }

  describe '.initialize' do
    it 'init object with parameters' do
      expect(subject.quantity).to eq quantity
      expect(subject.product).to eq product
      expect(subject.price).to eq price
    end
  end

  describe '#import_tax' do
    context 'imported product' do
      let(:product) { 'imported Mercedes' }

      it 'return 5 percent' do
        expect(subject.import_tax).to eq 500
      end
    end

    context 'domestic product' do
      let(:product) { 'Vinfast' }

      it 'return zero' do
        expect(subject.import_tax).to eq 0
      end
    end
  end

  describe '#sales_tax' do
    context 'not exempt product' do
      it 'return 10 percent' do
        expect(subject.sales_tax).to eq 1_000
      end
    end

    context 'exempt product' do
      let(:product) { 'chocolate bar' }

      it 'return zero' do
        expect(subject.sales_tax).to eq 0
      end
    end
  end

  describe '#total_price' do
    let(:quantity) { 2 }

    it 'return correct number' do
      expect(subject.total_price).to eq (quantity * price)
    end
  end

  describe '#total_tax' do
    it 'return total of sales tax and import tax' do
      allow(subject).to receive(:sales_tax).and_return(100)
      allow(subject).to receive(:import_tax).and_return(50)

      expect(subject.total_tax).to eq BigDecimal(150)
    end
  end
end
