-- activate or deactivate a user account
ALTER TABLE users ADD COLUMN active Boolean DEFAULT true;
UPDATE users SET active=true;

-- store database schema version
CREATE TABLE schema_version
(
  id serial NOT NULL,
  version character varying,
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schema_version OWNER TO edge;
COMMENT ON TABLE schema_version IS 'Store database schema version';