class SnapShotsController < ApplicationController


  def destroy
   @repo = Repo.find(params[:repo_id])
   @snapshot = SnapShot.find(params[:id])
   puts "+++++++++===destroy ss #{@snapshot.id}"
   @snapshot.destroy
  end
end
