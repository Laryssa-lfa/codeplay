class InstructorsController < ApplicationController
    before_action :set_instructor, only: %i[show edit update destroy]

    def index
        @instructors = Instructor.all
    end

    def show
    end

    def new
        @instructor = Instructor.new
    end

    def create
        @instructor = Instructor.create(instructor_params)
        if @instructor.save
            redirect_to @instructor, notice: 'Professor(a) registrado com sucesso!'
        else
            render :new, notice: 'Nenhum Professor(a) registrado!'
        end
    end

    def edit
    end

    def update
        @instructor.update(instructor_params)
        redirect_to @instructor, notice: 'Professor(a) atualizado(a) com sucesso!'
    end

    def destroy
        @instructor.destroy
        redirect_to instructors_path, notice: 'Professor(a) apagado com sucesso!'
    end

    private

    def instructor_params
        params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
    end

    def set_instructor
        @instructor = Instructor.find(params[:id])
    end
end
