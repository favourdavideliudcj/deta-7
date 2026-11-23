require 'sinatra'

# In-memory data store for projects and messages
PROJECTS = [
  { title: 'Rift Valley Logistics API', stack: 'Ruby on Rails • PostgreSQL', desc: 'Real-time fleet dispatch and route optimization backend.' },
  { title: 'Lakeview Payments Gateway', stack: 'Ruby • Sinatra • Redis', desc: 'High-throughput mobile money webhook processor.' },
  { title: 'Kibo Telemetry Engine', stack: 'Ruby • Sidekiq', desc: 'Asynchronous background worker pipeline processing 50k jobs/min.' }
].freeze

MESSAGES = []

get '/' do
  @active_page = 'home'
  erb :home
end

get '/projects' do
  @active_page = 'projects'
  @projects = PROJECTS
  erb :projects
end

get '/contact' do
  @active_page = 'contact'
  @submitted = false
  erb :contact
end

post '/contact' do
  @active_page = 'contact'
  MESSAGES << {
    name: params[:name],
    email: params[:email],
    message: params[:message],
    created_at: Time.now
  }
  @submitted = true
  @sender_name = params[:name]
  erb :contact
end

__END__

@@ layout
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RubyForge | Engineering Studio</title>
  <style>
    :root {
      --bg-page: #0f172a;
      --bg-card: #1e293b;
      --text-main: #f8fafc;
      --text-muted: #94a3b8;
      --ruby: #e11d48;
      --ruby-hover: #be123c;
      --border: #334155;
      --radius: 0.6rem;
      --max-width: 1080px;
    }

    *, *::before, *::after {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background-color: var(--bg-page);
      color: var(--text-main);
      line-height: 1.6;
      display: grid;
      grid-template-rows: auto 1fr auto;
      min-height: 100vh;
    }

    header {
      background-color: var(--bg-card);
      border-bottom: 1px solid var(--border);
      position: sticky;
      top: 0;
      z-index: 50;
    }

    .nav-bar {
      max-width: var(--max-width);
      margin: 0 auto;
      padding: 1rem 1.5rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .brand {
      font-weight: 800;
      font-size: 1.25rem;
      color: var(--text-main);
      text-decoration: none;
      letter-spacing: -0.02em;
    }

    .brand span {
      color: var(--ruby);
    }

    .nav-links {
      list-style: none;
      display: flex;
      gap: 1.5rem;
    }

    .nav-links a {
      text-decoration: none;
      color: var(--text-muted);
      font-weight: 600;
      font-size: 0.95rem;
      transition: color 0.15s;
    }

    .nav-links a:hover,
    .nav-links a[aria-current="page"] {
      color: var(--ruby);
    }

    main {
      max-width: var(--max-width);
      width: 100%;
      margin: 0 auto;
      padding: 3rem 1.5rem;
    }

    h1 {
      font-size: clamp(2rem, 5vw, 3rem);
      line-height: 1.15;
      letter-spacing: -0.03em;
      margin-bottom: 1rem;
    }

    p {
      color: var(--text-muted);
      margin-bottom: 1.5rem;
      max-width: 62ch;
    }

    .btn {
      display: inline-block;
      background-color: var(--ruby);
      color: #ffffff;
      font-weight: 600;
      padding: 0.75rem 1.5rem;
      border-radius: var(--radius);
      text-decoration: none;
      border: none;
      cursor: pointer;
      font-size: 0.95rem;
      transition: background-color 0.15s;
    }

    .btn:hover {
      background-color: var(--ruby-hover);
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 1.5rem;
      margin-top: 2rem;
    }

    .card {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 1.5rem;
    }

    .stack-badge {
      display: inline-block;
      font-size: 0.75rem;
      font-weight: 700;
      color: #fda4af;
      background: rgba(225, 29, 72, 0.15);
      padding: 0.2rem 0.6rem;
      border-radius: 4px;
      margin-bottom: 0.75rem;
    }

    .form-group {
      margin-bottom: 1.25rem;
      max-width: 480px;
    }

    label {
      display: block;
      font-weight: 500;
      margin-bottom: 0.4rem;
    }

    input, textarea {
      width: 100%;
      padding: 0.75rem;
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      color: var(--text-main);
      font-family: inherit;
    }

    input:focus, textarea:focus {
      outline: 2px solid var(--ruby);
      border-color: transparent;
    }

    .alert {
      background: rgba(16, 185, 129, 0.15);
      border: 1px solid #10b981;
      color: #6ee7b7;
      padding: 1rem;
      border-radius: var(--radius);
      margin-bottom: 1.5rem;
      max-width: 480px;
    }

    footer {
      border-top: 1px solid var(--border);
      padding: 1.75rem 1.5rem;
      text-align: center;
      color: var(--text-muted);
      font-size: 0.85rem;
    }
  </style>
</head>
<body>

  <header>
    <nav class="nav-bar" aria-label="Main Navigation">
      <a href="/" class="brand">Ruby<span>Forge</span></a>
      <ul class="nav-links">
        <li><a href="/" <%= 'aria-current="page"' if @active_page == 'home' %>>Home</a></li>
        <li><a href="/projects" <%= 'aria-current="page"' if @active_page == 'projects' %>>Projects</a></li>
        <li><a href="/contact" <%= 'aria-current="page"' if @active_page == 'contact' %>>Contact</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <%= yield %>
  </main>

  <footer>
    <p>&copy; <%= Time.now.year %> RubyForge Studio &bull; Powered by Ruby <%= RUBY_VERSION %> &amp; Sinatra</p>
  </footer>

</body>
</html>

@@ home
<h1>Server-Rendered Web Apps with Ruby</h1>
<p>Clean, maintainable architecture combining Ruby's expressive backend routing with semantic HTML5 and modern CSS Grid.</p>
<a href="/projects" class="btn">View Systems</a>

<div class="grid">
  <div class="card">
    <h3>Zero Build Step</h3>
    <p>Inline ERB templates keep markup, styles, and server logic cohesive and fast to deploy.</p>
  </div>
  <div class="card">
    <h3>RESTful Routing</h3>
    <p>Explicit HTTP verbs map cleanly to server-side controllers without client-side routing overhead.</p>
  </div>
</div>

@@ projects
<h1>Production Systems</h1>
<p>Recent backend APIs and distributed services engineered in Ruby.</p>

<div class="grid">
  <% @projects.each do |project| %>
    <article class="card">
      <span class="stack-badge"><%= project[:stack] %></span>
      <h2 style="font-size: 1.25rem; margin-bottom: 0.5rem;"><%= project[:title] %></h2>
      <p style="margin-bottom: 0;"><%= project[:desc] %></p>
    </article>
  <% end %>
</div>

@@ contact
<h1>Start a Conversation</h1>
<p>Send a message directly to the Ruby server endpoint below.</p>

<% if @submitted %>
  <div class="alert" role="status">
    Thanks, <strong><%= @sender_name %></strong>! Your message was received by the server.
  </div>
<% end %>

<form action="/contact" method="POST">
  <div class="form-group">
    <label for="name">Your Name</label>
    <input type="text" id="name" name="name" required>
  </div>

  <div class="form-group">
    <label for="email">Email Address</label>
    <input type="email" id="email" name="email" required>
  </div>

  <div class="form-group">
    <label for="message">Project Scope</label>
    <textarea id="message" name="message" rows="4" required></textarea>
  </div>

  <button type="submit" class="btn">Send to Server</button>
</form>
