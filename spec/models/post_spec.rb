require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '新規投稿' do
    before do
      @post = FactoryBot.build(:post)
    end

    context '新規投稿が保存できる時' do
      it 'image, rating, museum_name, prefecture_idが存在していれば保存できること' do
        expect(@post).to be_valid
      end

      it 'exhibition_titleが空でも保存できること' do
        @post.exhibition_title = ''
        @post.valid?
        expect(@post).to be_valid
      end

      it 'impressive_artistが空でも保存できること' do
        @post.impressive_artist = ''
        @post.valid?
        expect(@post).to be_valid
      end

      it 'impressive_workが空でも保存できること' do
        @post.impressive_work = ''
        @post.valid?
        expect(@post).to be_valid
      end

      it 'textが空でも保存できること' do
        @post.text = ''
        @post.valid?
        expect(@post).to be_valid
      end
    end

    context '新規投稿が保存できない時' do
      it 'imageが空では保存できないこと' do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("画像を入力してください")
      end

      it 'museum_nameが空では保存できないこと' do
        @post.museum_name = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("施設名を入力してください")
      end

      it 'ratingが空では保存できないこと' do
        @post.rating = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("おすすめ度を入力してください")
      end

      it 'prefecture_idが1（---）では保存できないこと' do
        @post.prefecture_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include('施設の所在地は1以外の値にしてください')
      end
    end
  end
end
