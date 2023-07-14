-- Создание таблицы profiles
CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthday DATE,
    is_active BOOLEAN DEFAULT true
);

-- Создание таблицы messages
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    text TEXT,
    sent_date DATE,
    FOREIGN KEY (sender_id) REFERENCES profiles(id),
    FOREIGN KEY (receiver_id) REFERENCES profiles(id)
);

-- Вставка данных в таблицу profiles
INSERT INTO profiles (first_name, last_name, birthday)
VALUES
    ('John', 'Doe', '1990-01-01'),
    ('Jane', 'Smith', '1985-05-10'),
    ('Michael', 'Johnson', '2002-07-15'),
    ('Emily', 'Davis', '1998-09-20'),
    ('David', 'Anderson', '2005-02-28'),
    ('Olivia', 'Taylor', '1992-12-03'),
    ('James', 'Brown', '1987-08-18'),
    ('Sophia', 'Miller', '2000-04-25'),
    ('William', 'Wilson', '1995-06-12'),
    ('Ava', 'Jones', '2003-10-30');

-- Вставка данных в таблицу messages
INSERT INTO messages (sender_id, receiver_id, text, sent_date)
VALUES
    (1, 2, 'Hello', '2022-01-01'),
    (2, 1, 'Hi', '2022-01-01'),
    (3, 4, 'How are you?', '2022-01-02'),
    (4, 3, 'I\'m fine, thanks', '2022-01-02'),
    (5, 6, 'Have a nice day', '2022-01-03'),
    (6, 5, 'Thank you', '2022-01-03'),
    (7, 8, 'What\'s up?', '2022-01-04'),
    (8, 7, 'Not much', '2022-01-04'),
    (9, 10, 'See you later', '2022-01-05'),
    (10, 9, 'Goodbye', '2022-01-05');

-- Отмечаем несовершеннолетних пользователей как неактивных
ALTER TABLE profiles
ADD COLUMN is_active BOOLEAN DEFAULT true;

UPDATE profiles
SET is_active = false
WHERE DATE_PART('year', AGE(birthday)) < 18;

-- Удаляем сообщения "из будущего"
DELETE FROM messages
WHERE sent_date > CURRENT_DATE;