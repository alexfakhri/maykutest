require 'rails_helper'

feature 'projects' do

  context 'no projects have been uploaded' do
    scenario 'Should have a prompt to add a new project' do
      visit '/projects'
      expect(page).to have_content "No projects have been added yet"
      expect(page).to have_link("add-project")
    end
  end

  context 'photos have been added' do

    before do
      Project.create(caption: 'This is an awesome project', image: File.open("#{Rails.root}/public/test.png"))
    end

    scenario 'displays the description' do
      visit '/projects'
      expect(page).to have_content('This is an awesome project')
      expect(page).not_to have_content('No photos yet')
    end

    scenario 'displays the photo' do
      visit '/projects'
      expect(page).to have_css("img[alt=Test]")
    end

  end

  context 'adding photos' do
    scenario 'prompts user to fill out a form, then displays the new project' do
      visit '/projects'
      click_link("add-project")
      attach_file "Image", "#{Rails.root}/public/test.png"
      fill_in 'Caption', with: 'This is an awesome project'
      click_button 'Create Project'
      expect(page).to have_content 'This is an awesome project'
      expect(page).to have_css("img[alt=Test]")
      expect(current_path).to eq '/projects'
    end
  end

  context 'viewing a photo' do

    before do
        @project = Project.create(caption: 'This is an awesome project', image: File.open("#{Rails.root}/public/test.png"))
    end

    scenario 'lets a user view a project' do
      visit '/projects'
      click_link "img-#{@project.id}"
      expect(page).to have_content 'This is an awesome project'
      expect(page).to have_css("img[alt=Test]")
      expect(current_path).to eq "/projects/#{@project.id}"
    end
    
  end

end
