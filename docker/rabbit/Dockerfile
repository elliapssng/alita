FROM rabbitmq:3.10.5-management

RUN echo "load_definitions = /mnesia.json" >> /etc/rabbitmq/conf.d/import.conf
COPY ./mnesia.json /mnesia.json