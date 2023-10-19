echo "###############"
echo "Comandi utili:"
echo "  user = User.find_by(:display_name => \"User Name\")"
echo "  user.activate!"
echo "  user.roles.create(:role => \"administrator\", :granter_id => user.id)"
echo "  user.save!"
echo "###############"
docker-compose run --rm web bundle exec rails console
