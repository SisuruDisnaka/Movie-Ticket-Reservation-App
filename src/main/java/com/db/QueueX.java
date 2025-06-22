package com.db;

public class QueueX {
    public int maxSize;
    public String[] queArray;
    public int front;
    public int rear;
    public int nItems;

    public QueueX(int size) {
        maxSize = size;
        queArray = new String[maxSize];
        front = 0;
        rear = -1;
        nItems = 0;
    }

    public void insert(String item) {
        if (isFull()) {
            remove();
        }
        rear = (rear + 1) % maxSize;
        queArray[rear] = item;
        nItems++;
    }

    public String remove() {
        if (isEmpty()) return null;
        String temp = queArray[front];
        front = (front + 1) % maxSize;
        nItems--;
        return temp;
    }

    public boolean isEmpty() {
        return nItems == 0;
    }

    public boolean isFull() {
        return nItems == maxSize;
    }

    public String[] getItemsInOrder() {
        String[] result = new String[nItems];
        for (int i = 0; i < nItems; i++) {
            int index = (front + i) % maxSize;
            result[i] = queArray[index];
        }
        return result;
    }
}
