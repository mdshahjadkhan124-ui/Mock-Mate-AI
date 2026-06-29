CREATE TABLE "chat_messages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"role" text NOT NULL,
	"content" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "chat_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now(),
	"updated_at" timestamp with time zone DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "company_type" text;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "focus_areas" text[];--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "deep_dive_topics" text[];--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "notes" text;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "overall_score" integer;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "overall_feedback" text;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "improvement_tips" text;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "precision_level" integer;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "nodes_analyzed" integer;--> statement-breakpoint
ALTER TABLE "interview_sessions" ADD COLUMN "growth_potential" text;--> statement-breakpoint
ALTER TABLE "resume_profiles" ADD COLUMN "company_type" text;--> statement-breakpoint
ALTER TABLE "resume_profiles" ADD COLUMN "focus_areas" text[];--> statement-breakpoint
ALTER TABLE "resume_profiles" ADD COLUMN "deep_dive_topics" text[];--> statement-breakpoint
ALTER TABLE "resume_profiles" ADD COLUMN "notes" text;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "free_trial_count" integer DEFAULT 3;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "has_seen_pricing" boolean DEFAULT false;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "trial_interviews_used" integer DEFAULT 0;--> statement-breakpoint
ALTER TABLE "chat_messages" ADD CONSTRAINT "chat_messages_session_id_chat_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."chat_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "chat_sessions" ADD CONSTRAINT "chat_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_chat_messages_session_id" ON "chat_messages" USING btree ("session_id");--> statement-breakpoint
CREATE INDEX "idx_chat_sessions_user_id" ON "chat_sessions" USING btree ("user_id");--> statement-breakpoint
ALTER TABLE "interview_answers" ADD CONSTRAINT "uq_session_question" UNIQUE("session_id","question_id");