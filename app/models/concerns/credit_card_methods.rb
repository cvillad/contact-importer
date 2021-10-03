module CreditCardMethods
  def save_credit_card
    self.franchise = credit_card_franchise
    self.credit_card_last_4 = credit_card.try(:last, 4)
    self.credit_card = credit_card_digest
  end

  private
  def credit_card_digest
    Digest::SHA2.hexdigest(credit_card)
  rescue
    credit_card
  end

  def credit_card_franchise
    credit_card&.credit_card_brand_name || 'Invalid franchise'
  end
end
