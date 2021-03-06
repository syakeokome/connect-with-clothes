class Item < ApplicationRecord

  attachment :image
  enum order_status: {
    "出品中":0, "購入済み":1
  }
  
  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true


  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  belongs_to :user
  has_one :order
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @item = Item.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("name LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tags(tags)
    tags.each do |new_tags|
      # selfは明示的に記載していてこの場合だとコントローラーの@postになる
      # tag_relationshipsがthroughしているのでtagsでアソシエーションを指定すると中間テーブルを通過した際に保存される。
      self.tags.find_or_create_by(name: new_tags)
    end
  end

  def update_tags(latest_tags)
    if self.tags.empty?
      # 既存のタグがなかったら追加だけ行う
      latest_tags.each do |latest_tag|
        self.tags.find_or_create_by(name: latest_tag)
      end
    elsif latest_tags.empty?
      # 更新対象のタグがなかったら既存のタグをすべて削除
      # 既に保存がされていたら既に登録されているタグの内容を削除
      self.tags.each do |tag|
        self.tags.delete(tag)
      end
    else
      # 既存のタグも更新対象のタグもある場合は差分更新
      current_tags = self.tags.pluck(:name)
      #左を起点に引き算をする
      #　　　　　　 b             a b c
      old_tags = current_tags - latest_tags
      #一致したものを取り出す
      # a c       a b c            b
      new_tags = latest_tags - current_tags

      # a  c
      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end


      new_tags.each do |new_tag|
        # b
        self.tags.find_or_create_by(name: new_tag)
        # self.tags << new_tags
      end
    end
  end
end
