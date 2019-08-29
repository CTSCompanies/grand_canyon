class LinksController < ApplicationController
  
	def index
		@links = Link.order(:hits).all
		render :index
	end

	def search
		query = params[:search]
		link  = Link.where(name: query).first

		if link && link.url
			hit(link)
			redirect_to link.url
		else
			@links = Link.where("lower(name) LIKE ?", "%#{query}%")
			render :index
		end
	end

	def show
  	end

	def new
	    @link = Link.new
	    render :new
	end

	def create
		exists = Link.where(name: link_params[:name]).exists?
	    @link = Link.new(link_params)

		if exists
			@notice = "Link Aready Exists"
			render :new    	
		elsif @link.save
			@links = Link.order(:hits).all
			@notice = 'Link was successfully created.'
			render :index
		else
			format.html { render :new }
		end
	end


    def hit(link)
      if link.hits.nil?
      	link.hits = 1
      else
      	link.hits += 1
      end
      link.save(:validate => false)
    end

    def validate
      super
      errors.add(:name, 'cannot be empty') if !name || name.empty?
      errors.add(:url, 'cannot be empty') if !url || url.empty?
    end

    def link_params
      params.permit(:name, :url)
    end
end