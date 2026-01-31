# digit_classifier.py
# Handwritten Digit Classification using ANN (MLP) on MNIST dataset

#1. Import libraries
import tensorflow as tf
from tensorflow.keras.datasets import mnist # type: ignore
from tensorflow.keras.models import Sequential # type: ignore
from tensorflow.keras.layers import Dense, Flatten # type: ignore
import matplotlib.pyplot as plt
import numpy as np

# 1. Load dataset
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# 2. Normalize pixel values (0–255 → 0–1)
X_train = X_train / 255.0
X_test = X_test / 255.0

# 3. Build the model
model = Sequential([
    Flatten(input_shape=(28, 28)),       # Flatten 28x28 images → 784 vector
    Dense(128, activation='relu'),       # Hidden layer 1
    Dense(64, activation='relu'),        # Hidden layer 2
    Dense(10, activation='softmax')      # Output layer (10 classes: digits 0–9)
])

# 4. Compile the model
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# 5. Train the model
history = model.fit(X_train, y_train, epochs=5, batch_size=32, validation_split=0.1)

# 6. Evaluate on test data
test_loss, test_acc = model.evaluate(X_test, y_test)
print(f"\n✅ Test Accuracy: {test_acc:.2f}")

# 7. Visualize a prediction
predictions = model.predict(X_test[:5])  # predict first 5 test images

for i in range(5):
    plt.imshow(X_test[i], cmap='gray')
    plt.title(f"True: {y_test[i]} | Predicted: {np.argmax(predictions[i])}")
    plt.axis('off')
    plt.show(block=False)
    plt.pause(2)   # show for 2 seconds
    plt.close()

print("First 10 true labels:", y_test[:10])


