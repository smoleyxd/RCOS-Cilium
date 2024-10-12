#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/netdevice.h>
#include <linux/ptrace.h>
#include <linux/skbuff.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <uapi/linux/bpf.h>

#define KBUILD_MODNAME "abnormal_traffic"
#include <bpf_helpers.h>
#include <linux/bpf.h>

// Define map to keep count of packet anomalies
struct bpf_map_def SEC("maps") packet_count = {
    .type = BPF_MAP_TYPE_PERCPU_ARRAY,
    .key_size = sizeof(__u32),
    .value_size = sizeof(__u64),
    .max_entries = 256,
};

// Function to identify packet size anomalies
SEC("socket_filter")
int packet_size_anomaly(struct __sk_buff *skb) {
  if (skb->len > 1500 || skb->len < 64) {
    __u32 key = 0;
    __u64 *value;

    // Look up the value for the key in the map
    value = bpf_map_lookup_elem(&packet_count, &key);
    if (value) {
      __sync_fetch_and_add(value, 1); // Increment the count
    }

    // Quarantine logic: Redirect the packet TBD (haven't decided on quarantine environment yet...thinking unique namespace?)
    bpf_skb_redirect(skb, BPF_F_INGRESS,
                     1);
  }

  return BPF_OK;
}

// Function to identify anomalies in connection patterns
SEC("socket_filter")
int connection_pattern_anomaly(struct __sk_buff *skb) {
  struct iphdr *iph = bpf_hdr_pointer(skb, 0, sizeof(*iph));
  if (!iph)
    return BPF_DROP;

  // Check if the protocol is TCP
  if (iph->protocol == IPPROTO_TCP) {
    struct tcphdr *tcph = (struct tcphdr *)(iph + 1);
    if (!tcph)
      return BPF_DROP;

    // Check for SYN flag indicating a new connection attempt
    if (tcph->syn && !tcph->ack) {
      __u32 key = iph->saddr;
      __u64 *value;

      // Look up the value for the key in the map
      value = bpf_map_lookup_elem(&packet_count, &key);
      if (value) {
        __sync_fetch_and_add(value, 1);
        if (*value > 100) {
          // Quarantine logic: Redirect the packet (same as above, unsure method as of rn...)
          bpf_skb_redirect(skb, BPF_F_INGRESS,
                           1);
        }
      } else {
        __u64 initial_count = 1;
        bpf_map_update_elem(&packet_count, &key, &initial_count, BPF_ANY);
      }
    }
  }

  return BPF_OK;
}

// Function to identify protocol violation anomalies
SEC("socket_filter")
int protocol_violation_anomaly(struct __sk_buff *skb) {
  struct iphdr *iph = bpf_hdr_pointer(skb, 0, sizeof(*iph));
  if (!iph)
    return BPF_DROP;

  // Check if the protocol is TCP
  if (iph->protocol == IPPROTO_TCP) {
    struct tcphdr *tcph = (struct tcphdr *)(iph + 1);
    if (!tcph)
      return BPF_DROP;

    // Check for invalid TCP flag combinations
    if (tcph->syn && tcph->fin) {
      __u32 key = 0;
      __u64 *value;

      // Look up the value for the key in the map
      value = bpf_map_lookup_elem(&packet_count, &key);
      if (value) {
        __sync_fetch_and_add(value, 1);
      }

      // Quarantine logic: Redirect the packet (unsure pt3)
      bpf_skb_redirect(skb, BPF_F_INGRESS,
                       1);
    }
  }

  return BPF_OK;
}

// Define license
char _license[] SEC("license") = "GPL";
