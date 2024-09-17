import React, { useState } from 'react';

const Login = () => {
    const [role, setRole] = useState('');
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [message, setMessage] = useState('');

    const handleLogin = async (event) => {
        event.preventDefault();

        const response = await fetch('/api/connect/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                role: role,
                name: name,
                mdp: password
            })
        });

        const data = await response.json();
        if (response.ok) {
            console.log('Login successful:', data);
            setMessage(`Login successful. Welcome ${data.nom} ${data.prenom} (${data.role})`);
            // Handle successful login
            // Redirect to appropriate page based on role, e.g.:
            // if (data.role === 'admin') { navigate('/admin-home'); }
        } else {
            console.error('Login failed:', data);
            setMessage(`Login failed: ${data}`);
            // Handle failed login
        }
    };

    return (
        <div>
            <h2>Login</h2>
            <form onSubmit={handleLogin}>
                <div>
                    <label>
                        Role:
                        <select value={role} onChange={(e) => setRole(e.target.value)} required>
                            <option value="">Select Role</option>
                            <option value="prof">Professor</option>
                            <option value="etudiant">Student</option>
                            <option value="admin">Admin</option>
                        </select>
                    </label>
                </div>
                <div>
                    <label>
                        Username:
                        <input
                            type="text"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            required
                        />
                    </label>
                </div>
                <div>
                    <label>
                        Password:
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            required
                        />
                    </label>
                </div>
                <button type="submit">Login</button>
            </form>
            {message && <p>{message}</p>}
        </div>
    );
};

export default Login;