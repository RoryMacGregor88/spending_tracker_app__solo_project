require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant' )
also_reload( '../models/*' )

get '/merchants' do
  @merchants = Merchant.all()
  erb( :'merchants/index' )
end

get '/merchants/new' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb( :'merchants/new' )
end

get '/merchants/show' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb( :'merchants/show' )
end

post '/merchants' do
  merchant = Merchant.new( params )
  merchant.save()
  redirect to('/merchants')
end

post '/merchants/:id/delete' do
  Merchant.delete( params[:id] )
  redirect to( '/merchants' )
end

get '/merchants/:id/update' do
  @merchant = Merchant.find( params[:id] )
  @merchants = Merchant.all()
  erb( :'/merchants/update' )
end

post '/merchants/:id' do
  merchant = Merchant.new( params )
  merchant.update()
  redirect to "/merchants"
end
