FROM jgravity/tensorflow-opencv:odin

WORKDIR /app
LABEL io.whalebrew.name 'exercise-pose-analyzer'
LABEL io.whalebrew.config.working_dir '/app'

COPY compile.sh ./
COPY lib/ ./lib/
RUN chmod u+x ./compile.sh && ./compile.sh

COPY models/ ./models/
RUN cd models/coco && chmod u+x download_models_wget.sh && ./download_models_wget.sh

COPY font/ ./font/
COPY multiperson/ ./multiperson/
COPY nnet/ ./nnet/
COPY util/ ./util/
COPY demo/ ./demo/

COPY config.py default_config.py exercise_analyzer.py run.py sort.py video_pose.py ./

ENTRYPOINT ["python", "video_pose.py"]
# CMD ["--help"]
CMD ["-f", "/app/testset/shoulder_press_1.mp4"]
