<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <title>분실물 검색</title>
</head>

<body>
	<% 
		String upload = request.getParameter("upload");
	%>
    <div class="container">
        <div class="row text-center py-5">
            <div class="col">
                <h1>분실물 매칭</h1>
                <p id="status">이미지로 분실물을 검색합니다.</p>
                <div class="spinner-border text-primary" id="loader">
                </div>
                <div class="card">
                    <img id="img"></img>
                    <div class="card-body">
                        <h1 id="result"></h1>
                        <input class="btn btn-outline-secondary" id="input" type="file" name="file" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
        crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
   
    <script>
        const img = document.getElementById('img');
        const result = document.getElementById('result');
        let input = document.getElementById('input');
        const modelPath = "./my_model/";
        const modelURL = modelPath + "model.json";
        const metadataURL = modelPath + "metadata.json";


        tmImage.load(modelURL, metadataURL).then(model => {
            document.getElementById('loader').style.display = 'none';
            document.getElementById('status').innerHTML = "이미지 등록하여 주세요"

            function run() {
                model.predict(img).then(predictions => {
                    console.log('Predictions: ', predictions);
                    predictions.sort((a, b) => (b.probability - a.probability));
                    result.innerHTML = predictions[0].className + ' ' + parseInt(predictions[0].probability * 100) + '%';
                });
            }

            img.src = "";

            input.addEventListener('change', (e) => {
                img.src = URL.createObjectURL(e.target.files[0]);
            }, false);

            img.onload = function () {
                run();
            };

        });
    </script>
</body>

</html>