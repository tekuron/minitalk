/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: danz <danz@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/16 16:24:00 by danzamor          #+#    #+#             */
/*   Updated: 2025/11/18 19:21:32 by danz             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define _DEFAULT_SOURCE
#define _POSIX_C_SOURCE 199309L
#include <signal.h>
#include <unistd.h>
#include "libft.h"
#include "ft_printf_bonus.h"
#include "minitalk_bonus.h"

void	confirmation_handler(int signum, siginfo_t *info, void *context)
{
	(void)context;
	if (signum == SIGUSR2)
		ft_printf("Message confirmation from %i\n", info->si_pid);
}

void	send_char(int server_pid, char c)
{
	int	i;

	i = 7;
	while (i >= 0)
	{
		if ((c >> i) & 1)
		{
			kill(server_pid, SIGUSR2);
			usleep(500);
		}
		else
		{
			kill(server_pid, SIGUSR1);
			usleep(500);
		}
		i--;
	}
}

void	send_message(int server_pid, char *message)
{
	while (*message)
	{
		send_char(server_pid, *message);
		message++;
	}
	send_char(server_pid, '\n');
	send_char(server_pid, '\0');
}

int	main(int argc, char **argv)
{
	struct sigaction	sa;

	sigemptyset(&sa.sa_mask);
	sa.sa_sigaction = confirmation_handler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	if (argc != 3)
	{
		ft_printf("Usage: ./client [SERVER PID] [MESSAGE]\n");
		return (1);
	}
	send_message(ft_atoi(argv[1]), argv[2]);
	return (0);
}
