ActiveAdmin.register Image do

  config.per_page = 10

  filter :title, as: :string

  index do
    selectable_column
    column :id
    column :img_name do |category|
      unless category.img_name.blank?
        image_tag(category.img_name.url(:thumb))
      end
    end
    column :likes_count
    column :title
    column :category
    default_actions
  end

  show do
    panel 'Image Details' do
      attributes_table_for image do
        row :title
        row :category
        row :img_name
      end
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.semantic_errors :base
    f.inputs 'Images', multipart: true do
      f.input :category
      f.input :title
      f.input :img_name, as: :file,
              hint: f.object.img_name.nil? ? f.template.content_tag(:span, 'no map yet') : f.template.image_tag(f.object.img_name.url(:thumb))
      f.input :remote_img_name_url, as: :url
    end
    f.actions
  end

  controller do

    def scoped_collection
      Image.includes(:category)
    end

  end

end