class LikesController < ApplicationController
    before_action :authenticate_user!, only: ['create']

    def create
        like = Like.new(user_id: current_user.id, message_id: params[:id])

        if like.save
            render json: { id: like.id, email: current_user.email, message: 'successfully liked!' }, status: 200
        else
            render json: { message: 'like failed.', errors: like.errors.messages }, status: 400
        end
    end

    def destroy
        like = Like.find(params[:id])

        if like.destroy
            render json: { id: like.id, email: current_user.email, message: 'successfully destroy a like.' }, status: 200
        else
            render json: { message: 'like destory failed.', errors: like.errors.messages }, status: 400
        end
    end
end
