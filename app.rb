require "bundler/setup"
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @surveys = Survey.all
  @questions = Question.all
  erb :index
end

post '/surveys' do
  name = params.fetch('name')
  @survey = Survey.create({:name =>name})
  redirect "/"
end

post '/questions' do
  text = params.fetch("text")
  survey_id = params.fetch("survey_id")
  @question = Question.create({:text => text, :survey_id => survey_id})
  @questions = Question.all()
  redirect "/surveys/#{survey_id}"

end

delete '/questions/:id' do
  @question = Question.find(params.fetch("id").to_i)
  @question.destroy()
  @questions = Question.all()
  redirect back
end

get '/questions' do
  @surveys = Survey.all()
  @questions = Question.find(params.fetch("survey_id").to_i)
  erb :survey
end



get '/surveys/:id' do
  @survey = Survey.find(params.fetch("id").to_i)
  @questions = Question.all()
  erb :survey
end

post '/surveys/:id' do
  @survey = Survey.find(params.fetch("id").to_i)
  survey_id = params.fetch("survey_id")
  text = params.fetch("text")
  @question = Question.create({:text => text, :survey_id => survey_id})
  redirect back
end

delete '/surveys/:id' do
  @survey = Survey.find(params.fetch("id").to_i)
  @survey.destroy()
  @surveys = Survey.all()
  redirect "/"
end

get '/questions/:id' do

  @question = Question.find(params.fetch("id").to_i)
  erb :question
end

post '/answers' do
  text = params.fetch("text")
  question_id = params.fetch("question_id").to_i
  @answer = Answer.create({:text => text, :question_id => question_id})
  @answers = Answer.all
  redirect back
end
