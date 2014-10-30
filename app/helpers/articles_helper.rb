module ArticlesHelper

  def article_desc(article)
    text_contents = article.contents.where(partial: ['content_text', 'content_image']).map {|c| c.value}.join(' ')
    text_contents.empty? ? '...' : strip_tags(text_contents).truncate(200)
  end
end