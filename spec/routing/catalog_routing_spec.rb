require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Routing" do
  describe "Paths Generated by Custom Routes:" do
    # paths generated by custom routes
    it "should have a path for showing the email form" do
      expect(:get => "/catalog/email").to route_to(:controller => 'catalog', :action => 'email')
    end
    it "should have a path for sending the email" do
      expect(:post => "/catalog/email").to route_to(:controller => 'catalog', :action => 'email')
    end
    it "should map {:controller => 'catalog', :action => 'sms'} to /catalog/sms" do
      expect(:get => "/catalog/sms").to route_to(:controller => 'catalog', :action => 'sms')
    end
    it "should map { :controller => 'catalog', :action => 'show', :id => 666 } to /catalog/666" do
      expect(:get => "/catalog/666").to route_to(:controller => 'catalog', :action => 'show', :id => "666")
    end
    it "should map {:controller => 'catalog', :id => '111', :action => 'librarian_view'} to /catalog/111/librarian_view" do
      expect(:get => "/catalog/111/librarian_view").to route_to(:controller => 'catalog', :action => 'librarian_view', :id => "111")
      expect(:get => librarian_view_catalog_path('111')).to route_to(:controller => 'catalog', :action => 'librarian_view', :id => "111")
    end
  end


  describe "catalog_path for SolrDocument", :test => true do
    it "should route correctly" do
      expect(:get => catalog_path(SolrDocument.new(:id => 'asdf'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'asdf')
    end

    context "should escape solr document ids" do

      it "should pass-through url-valid ids" do
        expect(:get => catalog_path(SolrDocument.new(:id => 'qwerty'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'qwerty')
      end

      it "should route url-like ids" do
        skip "This works if you configure your routing to have very liberal constraints on :id.. not sure how to go about testing it though"
        expect(:get => catalog_path(SolrDocument.new(:id => 'http://example.com'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'http://example.com')
      end

      it "should route ids with whitespace" do
        expect(:get => catalog_path(SolrDocument.new(:id => 'mm 123'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'mm 123')
      end

      it "should route ids with a literal '+'" do
        expect(:get => catalog_path(SolrDocument.new(:id => 'this+that'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'this+that')
      end

      it "should route ids with a literal '/" do
        skip "This works if you configure your routing to have very liberal constraints on :id.. not sure how to go about testing it though"
        expect(:get => catalog_path(SolrDocument.new(:id => 'and/or'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'and/or')
      end
    end
  end
end
