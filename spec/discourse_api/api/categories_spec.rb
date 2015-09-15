require 'spec_helper'

describe DiscourseApi::API::Categories do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#categories" do
    before do
      stub_get("http://localhost:3000/categories.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("categories.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.categories
      expect(a_get("http://localhost:3000/categories.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested categories" do
      categories = subject.categories
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end

    it "returns the requested categories with hash arg" do
      categories = subject.categories({})
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end
  end

  describe '#category_latest_topics' do
    before do
      stub_get("http://localhost:3000/category/category-slug/l/latest.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("category_latest_topics.json"), headers: { content_type: "application/json" })
    end

    it "returns the latest topics in a category" do
      latest_topics = subject.category_latest_topics('category-slug')
      expect(latest_topics).to be_an Array
    end
  end

  describe '#category_top_topics' do
    before do
      stub_get("http://localhost:3000/category/category-slug/l/top.json?api_key=test_d7fd0429940&api_username=test_user")
      .to_return(
        body: fixture("category_topics.json"), 
        headers: { content_type: "application/json" }
      )
    end

    it "returns the top topics in a category" do
      topics = subject.category_top_topics('category-slug')
      expect(topics).to be_an Array
    end
  end

  describe '#category_new_topics' do
    before do
      stub_get("http://localhost:3000/category/category-slug/l/new.json?api_key=test_d7fd0429940&api_username=test_user")
      .to_return(
        body: fixture("category_topics.json"), 
        headers: { content_type: "application/json" }
      )
    end

    it "returns the new topics in a category" do
      topics = subject.category_new_topics('category-slug')
      expect(topics).to be_an Array
    end
  end

  describe "#update_category" do
    before do
      stub_put("http://localhost:3000/c/1.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("categories.json"), headers: { content_type: "application/json" })
      stub_put("http://localhost:3000/g/1.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("groups.json"), headers: { content_type: "application/json" })
    end

    it "sets permission to a group" do
      subject.set_permission(1, 101, 1)
      expect(a_put("http://localhost:3000/c/1.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end
  end
end
