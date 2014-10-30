# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Home page
@page = Page.create(name: 'accueil') unless Page.find_by(name: 'accueil')

# Home page content
if @page
  puts "Create home page"
  @page.contents.create name: 'slogan', title: 'Accroître par le numérique le pouvoir d’agir', partial: 'content_slogan', fixed: true
  @page.contents.create name: 'description', title: 'Les Compagnons du Dev se donnent pour ambition d’accompagner les citoyens à devenir acteurs du numérique', value: 'Nous proposons un accompagnement au développement de compétences dans le domaine de la programmation informatique et des nouvelles technologies, pour offrir à tous de nouvelles voies d’accès vers l’éducation, l’emploi, la culture et le lien social.', fixed: true, partial: 'content_description'
  @page.contents.create name: 'encart-1', title: 'Education', value: 'Programmes entièrement dédiés aux enfants (programmation, robotique, DIY) au sein du Kids Coding Club.', link: '#', fixed: true, partial: 'content_item'
  @page.contents.create name: 'encart-2', title: 'Formation', value: "Sessions à destination de jeunes et d'adultes pour le développement et/ou le renforcement des compétences professionnelles.", link: '#', fixed: true, partial: 'content_item'
  @page.contents.create name: 'encart-3', title: 'Lien social', value: 'Soutiens spécifiques auprès des publics les plus fragiles et les plus éloignés du numérique', link: '#', fixed: true, partial: 'content_item'
  puts "Create content"
else
  puts "Home page already exist"
end