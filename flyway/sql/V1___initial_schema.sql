CREATE TABLE courses (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE questions (
	id SERIAL PRIMARY KEY,
	course_id INTEGER REFERENCES courses(id),
	question_text TEXT NOT NULL,
	user_uuid TEXT NOT NULL,
	upvotes INTEGER NOT NULL DEFAULT 0,
	last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE answers (
	id SERIAL PRIMARY KEY,
	question_id INTEGER REFERENCES questions(id),
	answer_text TEXT NOT NULL,
	user_uuid TEXT NOT NULL,
	upvotes INTEGER NOT NULL DEFAULT 0,
	last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()	
);

CREATE TABLE question_upvotes (
	question_id INTEGER REFERENCES questions(id),
	user_uuid TEXT NOT NULL,
	upvote_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	PRIMARY KEY (question_id, user_uuid)	
);

CREATE TABLE answer_upvotes (
	answer_id INTEGER REFERENCES answers(id),
	user_uuid TEXT NOT NULL,
	upvote_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	PRIMARY KEY (answer_id, user_uuid)
);

CREATE INDEX question_upvotes_user_id_idx ON 
  question_upvotes (user_uuid);

CREATE INDEX answer_upvotes_user_id_idx ON 
  answer_upvotes (user_uuid);

CREATE INDEX questions_course_id_idx ON
  questions (course_id);

CREATE INDEX answers_question_id_idx ON	
  answers (question_id);