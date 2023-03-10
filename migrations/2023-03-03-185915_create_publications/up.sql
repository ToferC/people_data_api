-- Your SQL goes here

CREATE TYPE publication_status AS ENUM (
    'planning',
    'in_progress',
    'draft',
    'submitted',
    'published',
    'rejected',
    'cancelled'
);

CREATE TABLE IF NOT EXISTS publications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

    publishing_organization_id UUID NOT NULL,
    FOREIGN KEY(publishing_organization_id)
        REFERENCES organizations(id) ON DELETE RESTRICT,

    lead_author_id UUID NOT NULL,
    FOREIGN KEY(lead_author_id)
        REFERENCES persons(id) ON DELETE RESTRICT,
    
    title VARCHAR(256) NOT NULL,
    subject_text VARCHAR(256) NOT NULL,

    publication_status publication_status NOT NULL,

    url_string VARCHAR(256),

    publishing_id VARCHAR(256),

    submitted_date TIMESTAMP,
    published_datestamp TIMESTAMP,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS publication_contributors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

    publication_id UUID NOT NULL,
    FOREIGN KEY(publication_id)
        REFERENCES publications(id) ON DELETE RESTRICT,

    contributor_id UUID NOT NULL,
    FOREIGN KEY(contributor_id)
        REFERENCES persons(id) ON DELETE RESTRICT,

    contributor_role VARCHAR(256) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);