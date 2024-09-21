FROM python:3.10 AS builder

COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN quarto render website 

FROM nginx:latest
COPY --from=builder /website/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]