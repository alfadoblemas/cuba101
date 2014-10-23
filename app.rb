require "cuba"
require "mote"
require "mote/render"
require "ohm"

Dir["./models/**/*.rb"].each { |f| require(f) }

Cuba.plugin(Mote::Render)

Cuba.use(Rack::Static, urls: %w(/js /css /img), root: "./public")

Cuba.define do
  on root do
    res.redirect("/talks")
  end

  on "talks" do
    on :id do |id|
      talk = Talk[id]

      on get do
        render("talk", talk: talk)
      end

      on "feedbacks" do
        on post, param("feedback") do |params|
          feedback = Feedback.new(params)
          feedback.talk = talk
          feedback.save

          res.redirect("/talks/#{ talk.id }")
        end
      end
    end

    on get do
      render("talks", talks: Talk.all)
    end

    on post, param("talk") do |params|
      talk = Talk.create(params)

      res.redirect("/talks/#{ talk.id }")
    end
  end
end
