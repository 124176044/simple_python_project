from flask import Flask, jsonify, request, send_file
from flask_cors import CORS
import numpy as np
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences
from sklearn.preprocessing import LabelEncoder
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from imblearn.over_sampling import RandomOverSampler
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, confusion_matrix
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Bidirectional, GRU, Dense
import matplotlib.pyplot as plt
import seaborn as sns

app = Flask(__name__)
CORS(app)

# Load your dataset
csv_path = "C:\\Users\\kamal\\OneDrive\\Desktop\\dataset1\\realfishdataset.csv"
df = pd.read_csv(csv_path)


oversampler = RandomOverSampler(sampling_strategy='not majority', random_state=42)
X_resampled, y_resampled = oversampler.fit_resample(df.drop('fish', axis=1), df['fish'])

df_balanced = pd.DataFrame(X_resampled, columns=df.columns[:-1])
df_balanced['fish'] = y_resampled

label_encoder = LabelEncoder()
df_balanced['fish'] = label_encoder.fit_transform(df_balanced['fish'])


X = df_balanced[['ph', 'temperature', 'turbidity']].values
y = df_balanced['fish'].values


X_padded = pad_sequences(X, padding='post', dtype='float32')


X_train, X_test, y_train, y_test = train_test_split(X_padded, y, test_size=0.2, random_state=42)

X_train = X_train.reshape(X_train.shape[0], X_train.shape[1], 1)
X_test = X_test.reshape(X_test.shape[0], X_test.shape[1], 1)


models = {
    'c1': Sequential([LSTM(50, input_shape=(X_train.shape[1], X_train.shape[2])), Dense(len(np.unique(y)), activation='softmax')]),
    'c2': Sequential([Bidirectional(LSTM(50, input_shape=(X_train.shape[1], X_train.shape[2]))), Dense(len(np.unique(y)), activation='softmax')]),
    'c3': Sequential([GRU(50, input_shape=(X_train.shape[1], X_train.shape[2])), Dense(len(np.unique(y)), activation='softmax')])
}


#pretrained model for prediciton(Lstm,Bilstm,Gru)
lstm_model_path = "C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\lstm_model_fish.h5"
bilstm_model_path = "C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\bilstm_model_fish.h5"
gru_model_path="C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\gru_model_fish.h5"

lstm_model = load_model(lstm_model_path)
bilstm_model = load_model(bilstm_model_path)
gru_model=load_model(gru_model_path)

# Load the label encoders
lstm_label_encoder_path = "C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\label_encoder_classes_lstm.npy"
bilstm_label_encoder_path = "C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\label_encoder_classes_bilstm.npy"
gru_label_encoder_path="C:\\Users\\kamal\\OneDrive\\Desktop\\PROJECT\\label_encoder_classes_gru.npy"

lstm_label_encoder = LabelEncoder()
lstm_label_encoder.classes_ = np.load(lstm_label_encoder_path, allow_pickle=True)

bilstm_label_encoder = LabelEncoder()
bilstm_label_encoder.classes_ = np.load(bilstm_label_encoder_path, allow_pickle=True)

gru_label_encoder = LabelEncoder()
gru_label_encoder.classes_ = np.load(gru_label_encoder_path, allow_pickle=True)

def generate_confusion_matrix(y_true, y_pred, class_names, filename):
    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt="d", cmap="Blues", xticklabels=class_names, yticklabels=class_names)
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.title('Confusion Matrix')
    plt.savefig(filename)

def train_and_save_confusion_matrix(category):
    global models, X_train, y_train, X_test, y_test, label_encoder

    model = models.get(category)

    if model:
        # Compile the model
        model.compile(loss='sparse_categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

        # Train the model
        history = model.fit(X_train, y_train, epochs=10, batch_size=32, validation_data=(X_test, y_test))

        # Save the confusion matrix
        y_pred_probs = model.predict(X_test)
        y_pred = np.argmax(y_pred_probs, axis=1)
        class_names = label_encoder.classes_.tolist()
        generate_confusion_matrix(y_test, y_pred, class_names, f'confusion_matrix_{category}.png')

        # Print message to console
        print(f'Your {category} model is complete')

@app.route('/train/<category>', methods=['GET'])
def train_model(category):
    global models, X_train, y_train, X_test, y_test, label_encoder

    model = models.get(category)

    if model:
        # Train the model
        train_and_save_confusion_matrix(category)
        return jsonify({'message': f'{category} model trained successfully'})
    else:
        return jsonify({'error': 'Invalid category'})

@app.route('/accuracy', methods=['GET'])
def get_accuracy():
    global models, X_test, y_test, label_encoder

    accuracies = {}

    for category, model in models.items():
        y_pred_probs = model.predict(X_test)
        y_pred = np.argmax(y_pred_probs, axis=1)
        accuracy = accuracy_score(y_test, y_pred)
        accuracies[category] = accuracy

    return jsonify({'test_accuracies': accuracies})

@app.route('/confusion_matrix/<category>', methods=['GET'])
def get_confusion_matrix(category):
    return send_file(f'confusion_matrix_{category}.png', mimetype='image/png')


def predict_fish_category(model, label_encoder, ph, temperature, turbidity):
    class_names = label_encoder.classes_

    ph_range = (5.5, 9.0)
    temperature_range = (4.0, 35.0)
    turbidity_range = (1.0, 15.8)

    if not (ph_range[0] <= ph <= ph_range[1]):
        return f"Invalid pH value. Please enter a value between {ph_range[0]} and {ph_range[1]}."
    elif not (temperature_range[0] <= temperature <= temperature_range[1]):
        return f"Invalid temperature value. Please enter a value between {temperature_range[0]} and {temperature_range[1]}."
    elif not (turbidity_range[0] <= turbidity <= turbidity_range[1]):
        return f"Invalid turbidity value. Please enter a value between {turbidity_range[0]} and {turbidity_range[1]}."
    else:
        new_data = np.array([[ph, temperature, turbidity]])
        new_data_padded = pad_sequences(new_data, padding='post', dtype='float32').reshape(1, 3, 1)

        prediction_probs = model.predict(new_data_padded)
        predicted_class = np.argmax(prediction_probs)

        return f'Predicted Fish Category: {class_names[predicted_class]}'
    
    
@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    model_type = data.get('model')
    ph = data.get('ph')
    temperature = data.get('temperature')
    turbidity = data.get('turbidity')

    if model_type == 'LSTM':
        prediction_result = predict_fish_category(lstm_model, lstm_label_encoder, ph, temperature, turbidity)
    elif model_type == 'BILSTM':
        prediction_result = predict_fish_category(bilstm_model, bilstm_label_encoder, ph, temperature, turbidity)
    elif model_type == 'GRU':
        prediction_result = predict_fish_category(gru_model, gru_label_encoder, ph, temperature, turbidity)
    else:
        prediction_result = 'Invalid model type.'

    return jsonify({'prediction': prediction_result})


if __name__ == '__main__':
   app.run(host='0.0.0.0')