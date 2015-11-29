module ApplicationHelper

	include HtmlBuilder
	def document_title
		if @title.present?
			"#{@title} - 追跡くん"
		else
			"追跡くん"
		end
	end
end
